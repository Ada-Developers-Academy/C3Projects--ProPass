Jeri
### What is a Pronounceable Password

A passphrase that you can communicate and more likely remember because it follows some of the rules of a real word

I have given you a dataset of the probability of letter pairs in `data/probability.csv` I derived this from the `data/noun.pnz` which is the nouns from the WordNet Dictionary.

As you can review in the driver `app.rb` we will construct our pronounceable passwords by finding the next letter based upon the last letter of the current password until we hit the password size limit. Something like `a -> b -> s -> s -> t -> e` or `absste`

##### You will use this to write 4 methods of the class PronounceablePassword
- `#read_probabilities` which will read the provided csv into a hash with the expectation that **letter pairs** are the keys and the **count** is the value
- `#possible_next_letters/1` which will return the set of probable letters based on the letter passed in as the first argument. eg. possible_next_letters(a) => [{aa=> 10}, {ab}=> 3}...] in decending order by the count.
- `#most_common_next_letter/1` will return the most common, highest count, letter in the possible next letters array
- `#common_next_letter/2` will return a random very common, high count, letter in the possible next letters array. The second optional argument should let you customize the size of the random letter pool. We do not want to provide any letter in the set but only the top x letters before be pick a random one.

##### Some things to consider
- Efficiency of searching for the `#possible_next_letters/1`
- Test efficiency
- How could be improve the dataset we use?
- How can we rewrite the driver without a while loop

##### Givens
- Specs
- Driver `app.rb`
- Dataset `data/probability.csv`

##### Homework
- revise the driver to not use while loops
- refactor how we read the letter and count data and update only the specs associated with the change of data format
