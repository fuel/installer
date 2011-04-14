#!/bin/bash

if [ -f "./oil" ]; then
        php oil $@
else

        if [ "$1" == "create" ]; then
                git clone --recursive git://github.com/fuel/fuel.git "./$2"
                php "./$2/oil" refine install
        else
                echo 'This is not a valid Fuel installation so Oil is a bit lost.'
                echo '        http://fuelphp.com/docs/installation/instructions.html'

        fi
fi
