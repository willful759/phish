# Phish

This is a small phishing website made for my security class. it's for the (in)famous website nhentai, made for educational purposes only.

# Building

You'll need to download the haskell build tool `stack` in order to build this project, once you do, you can just run `stack build` on the root
directory and stack will download and compile all the required packages, this can take quite some time.

# Usage

Once you build your project, you can start the Yesod server with `stack run` and view the site on your browser typing `localhost:3000/login`.
 
All the phished credentials will be added to the file `phish.txt`.
