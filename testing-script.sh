# change directory into each
for f in assignment-2*/ ; do
  if [[ -d $f ]]; then
    cd $f

    echo '\n ############## CURRENT PROJECT ##############'
    echo `pwd`

    find . -type f -name '*.class' -delete
    rm -f ./lexer/Tokens.java
    rm -f ./lexer/TokenType.java

    echo "--- TOKEN SETUP ---"
    javac lexer/setup/TokenSetup.java
    java lexer.setup.TokenSetup

    echo "--- COMPILING ---"
    javac lexer/Lexer.java

    echo "--- TESTING ---"
    mkdir test_output

    for test_file in `ls ../samples/`; do
      full_name=$(basename "$test_file")
      file_name="${full_name%.*}"

      echo "** Trying $full_name **"
      java lexer.Lexer ../samples/$full_name 2>&1 > test_output/$file_name.out

      echo "** Diffing $full_name (this should be blank): **"
      diff ../results/$file_name.out test_output/$file_name.out
    done

    cd ..
  fi
done