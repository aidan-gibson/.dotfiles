just doing some symlink bullshit temporarily until real [dotfiles](obsidian://open?vault=Ext%20Brain&file=dotfiles) solution



precommit can resolve symlinks to real files; fig out same thing but for aliases; also periodically run eclecticlight's alias fixing program

# zsh

- [ ] Look thru `.zshrc copy` and `.zshrcplayground` to see if missing anything from there

- [ ] go thru the files there's a bunch of todos in em and messy stuff
- [ ] fig out how i want to organize "functions" make sure they load async etc

[main obsid note](obsidian://open?vault=Ext%20Brain&file=Shell%20Commands)

[zsh scripting obsid note](obsidian://open?vault=Ext%20Brain&file=zsh%20scripting)

they're both inc, but eventually put a tldr of em in repo

- [ ] set up gh action to test how all the benchmarks change after every commit, make a graph
- [ ] alisma git hook for aliases 



how does current hook work? add it to global AND make it work for aliases





==needs to be bidirectional. if i edit my userscripts elsewhere and git push it'll fuck shit up on the mac.==







# philosophy



i want to be able to SEE everything in .dotfiles or in the gh repo. on gh repo it'll be submodules, in actual it'll be 



I should use submodules for things like Userscripts, PhoenixConfig etc 
