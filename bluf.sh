#!/usr/bin/bash

set -euo pipefail


wget --no-clobber "https://upload.wikimedia.org/wikipedia/commons/2/20/The_Phantom_of_the_Opera_%281925%29_preview.webm"
video="The_Phantom_of_the_Opera_(1925)_preview.webm"


# customize these variables to fit your video
opening_credit_duration="1:51"
middle_duration="1:40:19"  # length from end of opening credits to beginning of closing credits
closing_credits_start="1:42:10"
closing_credits_duration="35"


# auto-editor needs an audio track, even a silent one. comment these two lines out if your video already has an audio track
#ffmpeg -f lavfi -i anullsrc=channel_layout=stereo:sample_rate=44100 -i "$video" -c:v copy -c:a aac -shortest "$video"_with_audio.mp4
ffmpeg -f lavfi -i anullsrc=channel_layout=stereo:sample_rate=44100 -i "$video" -c:a aac -shortest "$video"_with_audio.mp4
video="$video"_with_audio.mp4

ffmpeg -ss 0 -i "$video" -t "$opening_credit_duration" -map 0 opening_credits.mp4
ffmpeg -ss "$opening_credit_duration" -i "$video" -t "$middle_duration" -map 0 middle.mp4
ffmpeg -ss "$closing_credits_start" -i "$video" -t "$closing_credits_duration" -map 0 closing_credits.mp4


auto-editor middle.mp4  --edit motion:threshold=90% --video-speed 1     --silent-speed 99999 --output-file 90.mp4
auto-editor middle.mp4  --edit motion:threshold=90% --video-speed 99999 --silent-speed 1     --output-file 90_less.mp4

auto-editor 90_less.mp4 --edit motion:threshold=80% --video-speed 1     --silent-speed 99999 --output-file 80.mp4
auto-editor 90_less.mp4 --edit motion:threshold=80% --video-speed 99999 --silent-speed 1     --output-file 80_less.mp4

auto-editor 80_less.mp4 --edit motion:threshold=70% --video-speed 1     --silent-speed 99999 --output-file 70.mp4
auto-editor 80_less.mp4 --edit motion:threshold=70% --video-speed 99999 --silent-speed 1     --output-file 70_less.mp4

auto-editor 70_less.mp4 --edit motion:threshold=60% --video-speed 1     --silent-speed 99999 --output-file 60.mp4
auto-editor 70_less.mp4 --edit motion:threshold=60% --video-speed 99999 --silent-speed 1     --output-file 60_less.mp4

auto-editor 60_less.mp4 --edit motion:threshold=50% --video-speed 1     --silent-speed 99999 --output-file 50.mp4
auto-editor 60_less.mp4 --edit motion:threshold=50% --video-speed 99999 --silent-speed 1     --output-file 50_less.mp4

auto-editor 50_less.mp4 --edit motion:threshold=40% --video-speed 1     --silent-speed 99999 --output-file 40.mp4
auto-editor 50_less.mp4 --edit motion:threshold=40% --video-speed 99999 --silent-speed 1     --output-file 40_less.mp4

auto-editor 40_less.mp4 --edit motion:threshold=30% --video-speed 1     --silent-speed 99999 --output-file 30.mp4
auto-editor 40_less.mp4 --edit motion:threshold=30% --video-speed 99999 --silent-speed 1     --output-file 30_less.mp4

auto-editor 30_less.mp4 --edit motion:threshold=20% --video-speed 1     --silent-speed 99999 --output-file 20.mp4
auto-editor 30_less.mp4 --edit motion:threshold=20% --video-speed 99999 --silent-speed 1     --output-file 20_less.mp4

auto-editor 20_less.mp4 --edit motion:threshold=10% --video-speed 1     --silent-speed 99999 --output-file 10.mp4
auto-editor 20_less.mp4 --edit motion:threshold=10% --video-speed 99999 --silent-speed 1     --output-file 10_less.mp4


ffmpeg -i opening_credits.mp4 -i 90.mp4 -i 80.mp4 -i 70.mp4 -i 60.mp4 -i 50.mp4 -i 40.mp4 -i 30.mp4 -i 20.mp4 -i 10.mp4 -i 10_less.mp4 -i closing_credits.mp4 \
-filter_complex "[0:v] [0:a] [1:v] [1:a] [2:v] [2:a] [3:v] [3:a] [4:v] [4:a] [5:v] [5:a] [6:v] [6:a] [7:v] [7:a] [8:v] [8:a] [9:v] [9:a] [10:v] [10:a] [11:v] [11:a] \
concat=n=12:v=1:a=1 [v] [a]" -map "[v]" -map "[a]" "$video".sorted.mp4

