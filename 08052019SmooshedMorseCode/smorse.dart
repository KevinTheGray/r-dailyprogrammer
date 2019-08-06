    import 'dart:io';
    import 'dart:math';

    final morseMap = {
      "a": ".-",
      "b": "-...",
      "c": "-.-.",
      "d": "-..",
      "e": ".",
      "f": "..-.",
      "g": "--.",
      "h": "....",
      "i": "..",
      "j": ".---",
      "k": "-.-",
      "l": ".-..",
      "m": "--",
      "n": "-.",
      "o": "---",
      "p": ".--.",
      "q": "--.-",
      "r": ".-.",
      "s": "...",
      "t": "-",
      "u": "..-",
      "v": "...-",
      "w": ".--",
      "x": "-..-",
      "y": "-.--",
      "z": "--..",
    };

    main(List<String> args) {
      final wordList = loadEnable1WordList();
      final word = args[0];
      print("main challenge, arg to morse: ${wordToMorse(word)}");
      print('Bonuses: ************');
      print("1. sequence shared by 13 words: ${bonus1(wordList)}");
      print(
          "2. perfectly balanced bonus: ${findPerfectlyBalancedWordsOfLength(21, wordList)[1]}");
      print(
          "3. palindrome bonus: ${findMorsePalindromesOfLength(13, wordList)[0]}");
      print(
          '4. 15 dashes bonus: ${findMorseWordWithMatchingPatterns('---------------', wordList)[0]}');
      print('5. 13 char sequences not in any word: ${bonus5(wordList, 13)}');
    }

    List<String> loadEnable1WordList() {
      final file = File('words.txt');
      return file.readAsLinesSync();
    }

    String wordToMorse(String word) {
      final builder = StringBuffer();
      for (int i = 0; i < word.length; i++) {
        builder.write(morseMap[word[i]]);
      }
      return builder.toString();
    }

    List<String> findPerfectlyBalancedWordsOfLength(
        int length, List<String> wordList) {
      List<String> validWords = [];
      for (final word in wordList) {
        if (word.length != length) {
          continue;
        }
        final morseWord = wordToMorse(word);
        if (morseWord.length % 2 != 0) {
          continue;
        }
        if (morseWord.replaceAll('.', '').length == morseWord.length / 2) {
          validWords.add(word);
        }
      }
      return validWords;
    }

    List<String> findMorsePalindromesOfLength(int length, List<String> wordList) {
      List<String> validWords = [];
      for (final word in wordList) {
        if (word.length != length) {
          continue;
        }
        final morseWord = wordToMorse(word);
        bool invalid = false;
        for (int i = 0; i < morseWord.length / 2; i++) {
          if (morseWord[i] != morseWord[morseWord.length - (i + 1)]) {
            invalid = true;
            break;
          }
        }
        if (!invalid) {
          validWords.add(word);
        }
      }
      return validWords;
    }

    List<String> findMorseWordWithMatchingPatterns(
        String pattern, List<String> wordList) {
      List<String> validWords = [];
      for (final word in wordList) {
        final morseWord = wordToMorse(word);
        if (morseWord.contains(pattern)) {
          validWords.add(word);
        }
      }
      return validWords;
    }

    MapEntry bonus1(List<String> wordList) {
      Map<String, List<String>> sharedMorseWords = {};
      for (final word in wordList) {
        final morseWord = wordToMorse(word);
        if (!sharedMorseWords.containsKey(morseWord)) {
          sharedMorseWords[morseWord] = [];
        }
        sharedMorseWords[morseWord].add(word);
      }
      return sharedMorseWords.entries.firstWhere((e) => e.value.length == 13);
    }

    List<String> bonus5(List<String> wordList, int len) {
      List<String> lenSequences = [];
      for (int i = 0; i < pow(2, len); i++) {
        final binString = (i.toRadixString(2)).padLeft(len, '0');
        lenSequences.add(binString.replaceAll('0', '.').replaceAll('1', '-'));
      }
      for (final word in wordList) {
        final morseWord = wordToMorse(word);
        if (morseWord.length < len) {
          continue;
        }
        lenSequences.removeWhere((seq) => morseWord.contains(seq));
      }
      return lenSequences;
    }
