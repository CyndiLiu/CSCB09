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
    echo '      <table>'

    col=$1
    if [ $col -le 0 ]
    then
        echo 'Invalid number of column.' >&2
   
    else
        shift
        count=1
        ends=3
        for files in $@
        do
            # Check if it is the JPED file
            if [ -f "$files" ] && file "$files" | grep -iq jpeg
            then
                # Check if it is the first picture of the column
                if [ $count -eq 1 ]
                then
                    echo '          <tr>'
                fi
                
                #Check if reaching the end of the column
                if [ $count -lt $col ]
                then
                    echo "              <td><img src=\"$files\" height=100></td>"
                    count=`expr $count + 1`
                    ends=0
                else
                    echo "              <td><img src=\"$files\" height=100></td>"
                    echo '          </tr>'
                    count=1
                    ends=1
                fi
            else
                echo "Invalid file: $files" >&2
            fi
        done

        if [ $ends -eq 0 ]
        then
            echo "          </tr>"
        fi
    fi
    echo '      </table>'
    echo '  </body> </html>'
fi

