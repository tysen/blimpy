#!/usr/bin/env bash
echo "------ Running Coverage Tests! ------"
if [[ $DIST == *"py3"* ]]; then
    python3 setup.py install; cd tests
    pip3 install coverage codecov pyyaml
else
    python setup.py install; cd tests
    pip install coverage codecov pyyaml
fi
apt-get install git
cd ..
coverage run --source=blimpy -m pytest
EXITCODE=$?
if [ $EXITCODE -ne 0 ]; then
    echo
    echo '*** Oops, coverage pytest failed, exit code = '$EXITCODE' ***'
    echo
    exit $EXITCODE
fi
coverage report
EXITCODE=$?
if [ $EXITCODE -ne 0 ]; then
    echo
    echo '*** Oops, coverage report failed, exit code = '$EXITCODE' ***'
    echo
    exit $EXITCODE
fi
codecov
