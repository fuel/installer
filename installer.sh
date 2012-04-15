#!/bin/bash

if [ -f "./oil" ]; then
        php oil "$@"
else

        if [ "$1" == "create" ]; then

                if [ ! `which git` ]; then 
                    echo "For this installer to work you'll need to install Git."
                    echo '        http://git-scm.com/'
                fi

                current_version=`curl http://fuelphp.com/current-version`

                git clone --recursive git://github.com/fuel/fuel.git "./$2" -b "$current_version/master"
                php "./$2/oil" refine install
        else
                echo 'This is not a valid Fuel installation so Oil is a bit lost.'
                echo '        http://fuelphp.com/docs/installation/instructions.html'

        fi
fi