#!/bin/fish
function swim
    argparse -i h/help l/loop r/reverse-loop s/single-line -- $argv
    or return

    if set -q _flag_h
        echo "help message"
        return 0
    end

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
        # Loop by going back to start
        if set -q _flag_l
            for frame in $framelist
                clear
                echo $frame
                sleep 0.1
            end
        end

        # Loop by reprinting frames in reverse
        if set -q _flag_r
            for frame in $framelist[-1..1]
                clear
                echo $frame
                sleep 0.1
            end
        end
        if set -q _flag_r
            for frame in $framelist
                clear
                echo $frame
                sleep 0.1
            end
        end
    end

    return 0
end

swim $argv
