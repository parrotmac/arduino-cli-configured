#!/usr/bin/env bash

set -euo pipefail

function install_with_brew() {
	brew update
	brew install arduino-cli
}

function install_with_curl() {
	curl -fsSL https://raw.githubusercontent.com/arduino/arduino-cli/master/install.sh | sh
}

function install_cli() {
	if command -v brew &> /dev/null
	then
		install_cli_with_brew
		brew install yq
	else
		download_cli_with_curl
		install -S bin/arduino-cli /usr/local/bin/arduino-cli
	fi
}

function configure_esp_boards() {
	arduino-cli config init || echo "Already configured"
	arduino-cli config set board_manager.additional_urls https://arduino.esp8266.com/stable/package_esp8266com_index.json https://raw.githubusercontent.com/espressif/arduino-esp32/gh-pages/package_esp32_index.json
	arduino-cli core update-index
	arduino-cli core install arduino:avr
	arduino-cli core install arduino:megaavr
	arduino-cli core install esp8266:esp8266
	arduino-cli core install esp32:esp32
	arduino-cli lib install ArduinoJson # https://arduinojson.org/?utm_source=meta&utm_medium=library.properties
	arduino-cli lib install EspMQTTClient # https://github.com/plapointe6/EspMQTTClient
	arduino-cli lib install "Adafruit NeoPixel" # https://github.com/adafruit/Adafruit_NeoPixel
	arduino-cli lib install "NeoPixelBus by Makuna" # https://github.com/Makuna/NeoPixelBus/wiki

}

configure_esp_boards

# List all installed boards
arduino-cli board listall

echo "Search for libraries: 'arduino-cli lib search <library_name>'"
echo "Search for boards: 'arduino-cli board search <board_name>'"