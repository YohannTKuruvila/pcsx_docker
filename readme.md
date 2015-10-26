# Run PCSX2 emulator from Docker

Exec emulator with X11 support from mini-container

## Dependencies

> ### #Docker
```shell
brew install caskroom/cask/cask-brew
brew install virtualbox
brew install docker
```

> ### #X11 support
```shell
brew install socat
brew cask install xquartz
```

## Run

```shell
chmod +x start-pcsx2.sh
./start-pcsx2.sh
```

## TODO

- [x] Init docker image build
- [ ] Provide BIOS files
- [ ] Provide optimal emulator config
- [ ] Setup binding with PS4 remote controller
- [ ] Test on [Phantasy Star II](http://pscave.com/psg2/download/)

## [Issues](https://github.com/sfate/pcsx_docker/issues)

## [MIT-license](/license.md)

## Version: 0.0.1 (2015-10-26)

