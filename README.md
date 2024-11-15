
# sisyphus

A Flutter application that displays real-time cryptocurrency data, including candlestick charts and order book data, using the Binance WebSocket API. This project leverages various Flutter packages to create an interactive and visually appealing UI.

## Overview

This app connects to the Binance WebSocket API to fetch real-time data on cryptocurrency trading pairs, displaying it in candlestick charts and order book format. Users can also view and interact with other trading options.

### Features
- Real-time candlestick charts
- Order book data updates in real-time
- Interactive UI with pull-to-refresh and smooth animations
- Clean and modular code structure using Riverpod for state management

## Video Demo

[![Watch the video](https://img.youtube.com/vi/VIDEO_ID_HERE/0.jpg)](https://www.youtube.com/watch?v=VIDEO_ID_HERE)

> Click the image above to watch a demo video of the app in action.

## Requirements

- Flutter SDK version 3.0.0 or later
- Binance API access for WebSocket data (no authentication required for public market data)

## Getting Started

### Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/emjaycodes/sisyphus_roqqu-assessment.git
   cd sisyphus_roqqu-assessment
   ```

2. **Install dependencies**:
   Run the following command to install the necessary Flutter packages.
   ```bash
   flutter pub get
   ```

3. **Run the app**:
   ```bash
   flutter run
   ```

### Dependencies

This project uses the following Flutter dependencies:

| Dependency                | Version    | Description |
|---------------------------|------------|-------------|
| `candlesticks`            | ^2.1.0     | Provides candlestick charting widgets for displaying market data. |
| `flutter_hooks`           | ^0.20.5    | Utilizes hooks for managing widget lifecycle and state. |
| `flutter_svg`             | ^2.0.10+1  | Renders SVG images in the UI, used for iconography and illustrations. |
| `hooks_riverpod`          | ^2.5.1     | State management solution that integrates with Flutter hooks. |
| `http`                    | ^1.0.0     | For making HTTP requests if needed. |
| `web_socket_channel`      | ^3.0.0     | Handles WebSocket connections to fetch real-time data from Binance. |
| `gap`                     | ^3.0.1     | Utility for adding spacing between UI components. |
| `intl`                    | ^0.19.0    | Internationalization support, used for date and number formatting. |
| `liquid_pull_to_refresh`  | ^3.0.1     | Pull-to-refresh widget with a liquid animation effect. |



## Key Functionality

### Candlestick Charts

Using the `candlesticks` package, this app displays historical market data in a candlestick format. The chart is updated in real-time via the WebSocket connection.

### Real-time Data with WebSocket

The `web_socket_channel` package enables real-time data streaming from Binance. Data is parsed and processed to display in the order book and candlestick chart.

### Pull-to-Refresh

The `liquid_pull_to_refresh` package provides a refreshing mechanism with a liquid animation, allowing users to manually refresh the data.

## Usage

1. **Connect to WebSocket**: The app automatically establishes a WebSocket connection to fetch real-time candlestick and order book data for a specific cryptocurrency trading pair.
2. **View Market Data**: Users can view the live candlestick chart, order book, and other market metrics.


