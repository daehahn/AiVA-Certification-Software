#!/bin/bash

mpg123 sound/speech_30s.mp3 &
arecord --format S16_LE -c2 --duration=30 --rate=44100 out.wav
aplay out.wav
rm out.wav

source ./sound_30s_speech.sh
