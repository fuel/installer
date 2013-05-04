#!/bin/bash

# if we have the oil script in the current directory, start that
if [ -f "./oil" ]; then
        php oil "$@"
else

		# check for bash commandline options
        if [ "$1" == "create" ]; then

				# make sure git is installed
                if [ ! `which git` ]; then
                    echo "For this installer to work you'll need to install Git."
                    echo '        http://git-scm.com/'
                fi

				# clone the repository, and make sure the latest master is active
                git clone --recursive git://github.com/fuel/fuel.git "./$2"
                cd ./$2
                branch=`git branch -a | grep -v "remote" | grep "master" | tail -1`
                branch=${branch#* }
                git checkout $branch
                git submodule foreach git checkout $branch
                
                # run composer
                php composer.phar self-update
                php composer.phar update
                
                # fix potential rights issues
                cd ..
                php "./$2/oil" refine install
        else
                echo 'This is not a valid Fuel installation so Oil is a bit lost.'
                echo '        http://fuelphp.com/docs/installation/instructions.html'

        fi
fi
