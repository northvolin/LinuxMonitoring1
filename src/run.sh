#!/bin/bash

rm -rf unit_test
rm -rf unit_tests
rm -rf *.[oa] && rm -rf *.gcno
rm -rf *.gcda
rm -rf *.info && rm -rf *.gcov
rm -rf ./test && rm -rf ./gcov_report
rm -rf ./report/
rm -f .clang-format

git add .
git commit -m "`date +\"%Y-%m-%d %H:%M:%S\"`"
git push origin develop
