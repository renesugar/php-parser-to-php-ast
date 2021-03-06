#!/usr/bin/env bash
EXPECTED_PATH=expected/all_output.expected
ACTUAL_PATH=all_output.actual
if [ ! -e $EXPECTED_PATH ]; then
	echo "Error: must run this script from tests/test_without_ast folder" 1>&2
	exit 1
fi
echo "Running test in '$PWD' ..."
rm $ACTUAL_PATH -f || exit 1
php --no-php-ini test.php | tee $ACTUAL_PATH
# diff returns a non-zero exit code if files differ or are missing
# This outputs the 
echo
echo "Comparing the output:"
diff $EXPECTED_PATH $ACTUAL_PATH
EXIT_CODE=$?
if [ "$EXIT_CODE" == 0 ]; then
	echo "Files $EXPECTED_PATH and output $ACTUAL_PATH are identical"
fi
exit $EXIT_CODE
