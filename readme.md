# Linux MateBook Audio Fix

This repository provides a script and systemd service to monitor and fix audio issues on Huawei MateBook laptops running Linux. The script uses `inotifywait` to monitor sound device access and executes `hda-verb` commands to adjust audio settings.

## Prerequisites

Before running the installation script, ensure you have the following dependencies installed:

- `inotify-tools`
- `hda-verb`
- `systemd`

You can install these dependencies using your package manager. For example, on Debian-based systems:

```sh
sudo apt-get update
sudo apt-get install inotify-tools hda-verb
```

## Installation

To install the audio fix, follow these steps:

1. Clone this repository:

   ```sh
   git clone https://github.com/yourusername/linux-matebook-audio-fix.git
   cd linux-matebook-audio-fix
   ```

2. Run the installation script:

   ```sh
   chmod +x install.sh
   ./install.sh
   ```

## How It Works

The installation script performs the following actions:

1. Creates a monitor script (`~/.monitor_sound.sh`) that uses `inotifywait` to watch for access to the `/dev/snd/` directory. When access is detected, it runs `hda-verb` commands to adjust the audio settings.
2. Makes the monitor script executable.
3. Creates a systemd service file (`/etc/systemd/system/monitor_sound.service`) to run the monitor script as a service.
4. Reloads the systemd daemon to recognize the new service.
5. Enables the service to start on boot.

## Usage

After installation, the service should start automatically. You can manage the service using `systemctl`:

- Start the service:

  ```sh
  sudo systemctl start monitor_sound
  ```

- Stop the service:

  ```sh
  sudo systemctl stop monitor_sound
  ```

- Check the status of the service:

  ```sh
  sudo systemctl status monitor_sound
  ```

- Enable the service to start on boot:

  ```sh
  sudo systemctl enable monitor_sound
  ```

- Disable the service from starting on boot:

  ```sh
  sudo systemctl disable monitor_sound
  ```

## Contributing

Contributions are welcome! Please open an issue or submit a pull request if you have any improvements or fixes.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
