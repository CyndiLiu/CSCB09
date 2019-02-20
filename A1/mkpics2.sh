if [ $# -eq 0 ]
then
    echo "Invalid number of argument." >&2
else
    echo '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">'
    echo '<html>'
    echo '  <head>'
    echo '      <title>Pictures</title>'
    echo '  </head>'
    echo '  <body>'
    echo '      <h1>Pictures</h1>'

    col=$1
    if [ $col -le 0 ]
    then
        echo 'Invalid number of column.' >&2
    else

        shift
        count=1
        ends=3

        # loop through directory year
        for i in "$1"/[0-9][0-9][0-9][0-9]
        do
            year=`basename $i`
            echo "      <h2>"$year"</h2>"

            echo "          <table>"
            
            # loop through directory month
            for j in $i/*
            do
                if [ -d  $j ] 
                then
                    
                    # loop through all the pictures
                    for z in $j/*
                    do
                        if [ $count -eq 1 ]
                        then
                            echo '          <tr>'
                        fi

                        if [ -f "$z" ] && file "$z" | grep -iq jpeg
                        then
                            # Check if it is the first picture of the column
                            if [ $count -lt $col ]
                            then
                                echo "              <td><img src=\"$z\" height=100></td>"
                                count=`expr $count + 1`
                                ends=0
                            else
                                echo "              <td><img src=\"$z\" height=100></td>"
                                echo '          </tr>'
                                count=1
                                ends=1
                            fi
                        else
                            echo "Invalid file: $z" >&2
                        fi
                    done
                fi
            done
            if [ $count -gt 1 ]
            then
                echo '          </tr>'
                count=1
            fi
            echo "          </table>"
        done


    fi
    echo '  </body>'
    echo '</html>'
fi

