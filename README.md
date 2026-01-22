# BeginnerJam1

1st Beginner/Learn Jam project from the [Godot Collaborative Game Jam community](https://discord.gg/UHN4AjMw4d)

## Folder structure

- The Godot project resides in `project/`
- All assets produced by our community are placed in `project/assets/` under the *CC BY-NC-SA 4.0* license
- All assets not produced by us are placed in `project/external_assets/` with their respective licenses

## Contribution rules

- The main branch is protected and the only way to make additions is via a Pull Request
- One successful review is required for a PR to pass and get merged into the main branch
- Everyone can be a reviewer, we don't enforce any review standards. Code quality, formatting, readability, etc shouldn't be reasons for rejections
- ..we recommend however that you read and follow the [official GDScript Style Guide](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_styleguide.html)
- All files and folders should follow the snake case convention ( `your_file.gd` )
- Branch naming conventions aren't enforced ( but you can find a cheatsheet [here](https://medium.com/@abhay.pixolo/naming-conventions-for-git-branches-a-cheatsheet-8549feca2534) )
- Most of our discussions will naturally take place in Discord, we can't expect everyone to be aware of information that's exlusively posted here

## Contribution process

- We recommend to use the Github Desktop App unless you're already familiar with git and prefer the command line / editor plugins
- Find a task in Discord first. You should post a message there as soon as you start working on a feature, so we don't get 2 people working on the same thing
- Fetch the latest changes from the main branch so it's up-to-date
- Create a new branch and start working on it like you normally would
- Keep your work on that branch contained to the feature you're working on and look for a quick turnaround. The sooner you merge, the lower the risk of merge conflicts
- Make sure the game still works after implementing your updates and address potential warnings in the *Debugger* window that your new code is causing
- When you're done creating a Pull Request wait for the review. You can enable auto-merge so it gets merged as soon as a review is successful
- As a code reviewer: Merge the branch yourself once it has passed
- You may still have to resolve potential merge conflicts. By communicating early on Discord about which parts we're working on we should be able to avoid them mostly though.
- Check in from time to time or set up your notifications so you can react to potential code change requests from reviewer asap
- If you need to update your branch with changes made to main during development use *Rebasing*
