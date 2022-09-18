#!/bin/bash
echo "Input settings [Link, a/v/t Selection]"
read $LINK $PARAMETERS $SLECTION
$HASH = md5($LINK)
cd ~/desktop
mkdir $HASH
cd $HASH
if [-z $SLECTION]
then if [$PARAMETERS = 'a' || $PARAMETERS = 'A']
then youtube-dl --add-metadata --metadata-from-title "%(artist)s - %(title)s" --embed-thumbnail -x --audio-format mp3 -f bestaudio[asr<=44100] $LINK
fi if [$PARAMETERS = 'v' || $PARAMETERS = 'V']
then youtube-dl --add-metadata --embed-thumbnail f bestaudio+bestvideo --format mp4 $LINK
fi if [$PARAMETERS = 't' || $PARAMETERS = 'T']
then youtube-dl --write-thumbnail $LINK
fi else if [$PARAMETERS = 'a' || $PARAMETERS = 'A']
then youtube-dl --add-metadata --metadata-from-title "%(artist)s - %(title)s" --embed-thumbnail -x --audio-format mp3 -f bestaudio[asr<=44100] --playlist-items $SLECTION $LINK
fi if [$PARAMETERS = 'v' || $PARAMETERS = 'V']
then youtube-dl --add-metadata --embed-thumbnail f bestaudio+bestvideo --format mp4 --playlist-items $SLECTION $LINK
fi if [$PARAMETERS = 't' || $PARAMETERS = 'T']
then youtube-dl --write-thumbnail --playlist-items $SLECTION $LINK
fi
if [$PARAMETERS = 'a' || $PARAMETERS = 'A']
then
echo "Lauching piacrd"
open -a "picard" *.mp3
read
echo "Lauching itunes"
open -a "itunes" *.mp3
read
cd ../
rm -R $HASH
ehco "Exiting"
fi
