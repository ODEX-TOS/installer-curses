
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![GPL License][license-shield]][license-url]



<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://github.com/ODEX-TOS/installer-curses">
    <img src="https://tos.pbfp.xyz/images/logo.svg" alt="Logo" width="150" height="200">
  </a>

  <h3 align="center">cli installer</h3>

  <p align="center">
    Install TOS through a simple cli installer
    <br />
    <a href="https://github.com/ODEX-TOS/installer-curses"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/ODEX-TOS/installer-curses">View Demo</a>
    ·
    <a href="https://github.com/ODEX-TOS/installer-curses/issues">Report Bug</a>
    ·
    <a href="https://github.com/ODEX-TOS/installer-curses/issues">Request Feature</a>
  </p>
</p>



<!-- TABLE OF CONTENTS -->
## Table of Contents

* [About the Project](#about-the-project)
  * [Built With](#built-with)
* [Getting Started](#getting-started)
  * [Prerequisites](#prerequisites)
  * [Installation](#installation)
* [Usage](#usage)
* [Roadmap](#roadmap)
* [Contributing](#contributing)
* [License](#license)
* [Contact](#contact)
* [Acknowledgements](#acknowledgements)



<!-- ABOUT THE PROJECT -->
## About The Project

> This installer has a limited customizability. If you want more "rare" configurations you shoudl use the `installer-gui` or create your own configs and generate your installer using the `tos-installer-backend`

This installer has the majority of normal features a normal user would need. These you can do with the installer

* setup a efi or mbr disk
* setup a disk with or without encryption
* setup a disk with 1 root partition or with both a root and a home partition

The installer will only install 1 disk, if you need to mount multiple disks you should do that after the install or edit the gen.yaml file yourself

The installer doesn't support dual booting or resizing exisiting partitions. If you want those features you should write your own `yaml` file or use the installer-gui.

If you are using this to build your server and need more features then it is recommended to write your own `yaml` file as they are usefull for mass server deployment.


<!-- GETTING STARTED -->
## Getting Started

To get a local copy up and running follow these simple steps.

### Prerequisites

All you need is the installer-backend and this git package
simply clone the following

```bash
git clone https://github.com/ODEX-TOS/tos-installer-backend
# install the python-yaml package
pip install python-yaml
```

### Installation
 
1. Clone the installer-curses repo
```sh
git clone https://github.com/ODEX-TOS/installer-curses.git
```
2. add execute permission
```bash
chmod +x installer-curses install.sh
```
3. make sure the tos-installer-backend repo is in your path



<!-- USAGE EXAMPLES -->
## Usage

simply run the install script. Once it finished you get a `gen.yaml` file specifying your system
If you are satisfied with your system run the following
```bash
python3 tos-installer-backend/main.py --in gen.yaml --out run.sh
```

The run.sh script is the shell script to run on your live system. This will mount, format and prepare your system. Once the script is finished you will have a working tos install

```bash
bash run.sh
```

Now reboot into your new system

_For more examples, please refer to the [Documentation](https://tos.pbfp.xyz/blog)_



<!-- ROADMAP -->
## Roadmap

See the [open issues](https://github.com/ODEX-TOS/installer-curses/issues) for a list of proposed features (and known issues).



<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to be learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request



<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE` for more information.



<!-- CONTACT -->
## Contact

F0xedb - tom@odex.be

Project Link: [https://github.com/ODEX-TOS/installer-curses](https://github.com/ODEX-TOS/installer-curses)



<!-- ACKNOWLEDGEMENTS -->
## Acknowledgements

* [ODEX-TOS](https://github.com/ODEX-TOS/installer-curses)





<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/ODEX-TOS/installer-curses.svg?style=flat-square
[contributors-url]: https://github.com/ODEX-TOS/installer-curses/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/ODEX-TOS/installer-curses.svg?style=flat-square
[forks-url]: https://github.com/ODEX-TOS/installer-curses/network/members
[stars-shield]: https://img.shields.io/github/stars/ODEX-TOS/installer-curses.svg?style=flat-square
[stars-url]: https://github.com/ODEX-TOS/installer-curses/stargazers
[issues-shield]: https://img.shields.io/github/issues/ODEX-TOS/installer-curses.svg?style=flat-square
[issues-url]: https://github.com/ODEX-TOS/installer-curses/issues
[license-shield]: https://img.shields.io/github/license/ODEX-TOS/installer-curses.svg?style=flat-square
[license-url]: https://github.com/ODEX-TOS/installer-curses/blob/master/LICENSE.txt
[product-screenshot]: https://tos.pbfp.xyz/images/logo.svg
