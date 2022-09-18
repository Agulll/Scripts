#!/bin/bash
echo "Input Link ; parameters {a/v/t} ; selection: "
read LINK PARAMETERS SELECTION
HASH="$(echo "${LINK}" | md5sum | sed 's/  -$//')"
cd ~/desktop
mkdir $HASH
cd $HASH
pwd
if [ -z "$SELECTION"];
then
    echo "No selection."
    if [ $PARAMETERS = 'a' ] || [ $PARAMETERS = 'A' ];
      then
        echo "Downloading audio."
        youtube-dl --yes-playlist --add-metadata --metadata-from-title "%(artist)s - %(title)s" -f "bestaudio[asr<=44100]" --embed-thumbnail -x --audio-format mp3 $LINK
    fi
    if [ $PARAMETERS = 'v' ] || [ $PARAMETERS = 'V' ];
      then
        echo "Downloading video."
        youtube-dl --yes-playlist --add-metadata --embed-thumbnail f bestaudio+bestvideo --merge-output-format mp4 $LINK
    fi
    if [ $PARAMETERS = 't' ] || [ $PARAMETERS = 'T' ];
      then
        echo "Downloading the thumbnail."
        youtube-dl --yes-playlist --write-thumbnail $LINK
    fi
else
    if [ $PARAMETERS = 'a' ] || [ $PARAMETERS = 'A' ];
      then
        echo "Downloading audios."
        youtube-dl --yes-playlist --add-metadata --metadata-from-title "%(artist)s - %(title)s" -f "bestaudio[asr<=44100]" --embed-thumbnail -x --audio-format mp3 --playlist-items $SLECTION $LINK

    fi
    if [ $PARAMETERS = 'v' ] || [ $PARAMETERS = 'V' ];
      then
        echo "Downloading videos."
        youtube-dl --yes-playlist --add-metadata --embed-thumbnail f bestaudio+bestvideo --merge-output-format mp4 --playlist-items $SLECTION $LINK
    fi
    if [ $PARAMETERS = 't' ] || [ $PARAMETERS = 'T' ];
      then
        echo "Downloading the thumbnails."
        youtube-dl --yes-playlist --write-thumbnail --playlist-items $SLECTION $LINK
    fi
fi
if [$PARAMETERS = 'a' ] || [ $PARAMETERS = 'A'];
  then
    echo "Lauching piacrd"
    open -a "picard" *.mp3
    read
    echo "Lauching itunes"
    open -a "itunes" *.mp3
    read
    cd ../
    rm -R $HASH
fi
ehco "Exiting"
