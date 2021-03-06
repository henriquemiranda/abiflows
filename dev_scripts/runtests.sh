#!/bin/bash
set -ev  # exit on first error, print each command

abinit --version
abinit --build
abicheck.py --with-flow

nosetests -v --with-coverage --cover-package=abiflows --logging-level=INFO --doctest-tests
#pytest -n 2 --cov-config=.coveragerc --cov=abiflows -v

# Generate documentation
if [[ "${TRAVIS_PYTHON_VERSION}" == "3.6" && "${TRAVIS_OS_NAME}" == "linux" ]]; then
    pip install -r ./docs/requirements.txt
    cd ./docs && make && cd ..;
fi
