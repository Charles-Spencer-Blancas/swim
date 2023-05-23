#!/bin/fish
function swim
    clear

    for line in (cat animation.txt)
        if test $line = \#
            set framelist $framelist $frame
            set frame ""
            sleep 0.1
            clear
            continue
        end

        echo $line

        # If frame is empty, set it to the current line
        if test -z $frame
            set frame $line
            continue
        end

        set frame $frame\n$line # Append current line to frame
    end

    while true
        for frame in $framelist[-1..1]
            clear
            echo $frame
            sleep 0.1
        end

        for frame in $framelist
            clear
            echo $frame
            sleep 0.1
        end

    end
end

swim
