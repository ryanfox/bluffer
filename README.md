# BLUFfer

## A NaMoGenMo 2023 Entry

For more information see [the writeup here](https://foxrow.com/namogenmo-2023) or [NaMoGenMo on GitHub.](https://github.com/NaMoGenMo/2023)

<iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/cOuy6GmQRJw?si=qytmAJNRKf_L6Otj" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>


## Usage
Clone the repository and `cd` to the project directory.

Install the prerequisites. You will need `ffmpeg` and `auto-editor`. On debian-like systems:
```
sudo apt install ffmpeg
```
```
pip install -r requirements.txt

(or)

pip install auto-editor
```

Edit the variables at the start of `bluf.sh` according to your desired video file.

When that is done, execute the program via `sh ./bluf.sh`.

Note: the script will create some intermediate files in the working directory, potentially overwriting them if they exist.

