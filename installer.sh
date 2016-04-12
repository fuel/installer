#!/bin/bash

# if we have the oil script in the current directory, start that
if [ -f "./oil" ]; then
        php oil "$@"
else

        # check for bash commandline options
        if [ "$1" == "create" ]; then
                COMPOSER="composer"
                DOWNLOAD=0

                # check if composer is installed
                if [ ! `which composer` ]; then
                    php -r "readfile('https://getcomposer.org/installer');" | php
                    php composer.phar > /dev/null
                    if [ $? -ne 0 ]; then
                        php -r "readfile('http://getcomposer.org/installer');" | php
                        php composer.phar > /dev/null
                        if [ $? -ne 0 ]; then
                            echo "Can't download composer.phar."
                            echo 'Please install Composer manually. See https://getcomposer.org/doc/00-intro.md'
                            exit 1
                        fi
                    fi

                    COMPOSER="php composer.phar"
                    DOWNLOAD=1
                fi

                # remove argument `create`
                shift

                # run composer
                echo "$COMPOSER create-project fuel/fuel $@"
                $COMPOSER create-project fuel/fuel $@

                # move downloaded `composer.phar`
                if [ $DOWNLOAD -eq 1 ]; then
                    mv composer.phar "$1"
                fi
        else
                echo 'This is not a valid Fuel installation so Oil is a bit lost.'
                echo '        http://fuelphp.com/docs/installation/instructions.html'

        fi
fi
