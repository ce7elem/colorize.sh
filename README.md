
<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://github.com/TERRUSS/colorize.sh">
    <img src="images/logo.png" alt="Logo" width="80" height="80">
  </a>

  <h3 align="center">colorise.sh</h3>

  <p align="center">
    A simple cli-tool to colour up your black&white pictures
    <br />
    <br />
    <a href="https://github.com/TERRUSS/colorize.sh">View Demo</a>
    ·
    <a href="https://github.com/TERRUSS/colorize.sh/issues">Report Bug</a>
    ·
    <a href="https://github.com/TERRUSS/colorize.sh/issues">Request Feature</a>
  </p>
</p>

<!-- ABOUT THE PROJECT -->
## Brief

[![colorize.sh demo][images/demo.gif]](https://github.com/TERRUSS/colorize.sh)

A very simple CLI tool that magically turns your Black&White pictures into coloured ones !

### Built With
Basically it’s a bash wrapper for the <a href=“https://deepai.org/machine-learning-model/colorizer”><strong>DeepAI machine learning coloriser API</strong></a>

* [DeepAI coloriser API](https://deepai.org/machine-learning-model/colorizer)
* [jq](https://stedolan.github.io/jq/) : the `sed` for JSON data

### Installation

1. Get a free API Key at [DeepAI](https://deepai.org/machine-learning-model/colorizer) (you have a few try without register if you want)
2. Get the dependencies
```sh
For Linux (Debian)
$ apt install curl jq
For MacOS
$ brew install curl jq
```
3. Clone the repo
```sh
git clone https://github.com/TERRUSS/colorize.sh && cd colorize.sh
```
4. Enter your API in `colorize.sh`
```bash
API_KEY = 'ENTER YOUR API';
```
5. Add the command to your `$PATH`
```sh
echo “PATH=$PATH:<~/path/to/the/project>” >> ~/.bashrc && source ~/.bashrc
```
6. You can now use the command `colorize.sh` everywhere !
```sh
$ ls
hello.jpg
$ colorize.sh hello.jpg
	...
$ ls
hello.jpg hello_colorized.jpg
```

<!-- USAGE EXAMPLES -->
## Usage

Just pass the path of your b&w pic in parameter and that’s it !

```sh
$ ls
hello.jpg
$ colorize.sh hello.jpg
	...
$ ls
hello.jpg hello_colorized.jpg
```

<!-- TROUBLESHOOTING -->
## Troubleshooting

You may have some issues with the selection menu if you're not using a recent `bash`version.
If you are using a different shell by default, just lauch the script with `bash ./colorize.sh` (eventually add an alias in your `.xxrc`)

If your `bash --version` is below `5.x.x`, make yourself a favour and get up to date
```sh
On linux (Debian) :
$ sudo apt update && sudo apt install bash
On mac
$ brew install bash (and open a new terminal window)
```

Also, if you're using zsh  by default, you may have this kind of error :
```sh
zsh: operation not permitted: colorize.sh
```
A simple trick should fix it: Add this line at the end of your `~/.zshrc`
```sh
alias colorize.sh='bash ~/path/to/folder/colorize.sh'
```
Dont forget to check your `bash --version` (should be > 5.x.x)

If you have a better solution please don't hesitate to contact me ! :D

<!-- LICENSE -->
## License

Distributed under the The Unlicense license. See `LICENSE` for more information.


<!-- ACKNOWLEDGEMENTS -->
## Acknowledgements
* [DeepAI coloriser API](https://deepai.org/machine-learning-model/colorizer)
* [jq](https://stedolan.github.io/jq/) : the `sed` for JSON data
* [DeepAI coloriser API](https://deepai.org/machine-learning-model/colorizer)
* Original icon made by [Freepik](https://www.freepik.com) from [Flaticon](https://www.flaticon.com), modified
