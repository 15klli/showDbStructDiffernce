# showDbStructDiffernce

#### Description

Find the difference between `fromTable` & `toTable` database,and generate the sql to make `fromTable` same as `toTable` **SAFELY**

#### Apply Situation
When the project need to deploy to the producing environment from test/dev environment, this tool can be used to ensure the database in produce same as the one in test/dev. 
And, we don't need to accelerate the modify sql any more! 

#### Quick Start
##### From File
1. use `Navicat` Software to export the database structure.  
2. After the first step, you get two `.sql` file. One is the sql file exported from the database **NEED TO CHANGE**(called `fromTable`), another is exported from the database ** HAS THE STRUCTURE YOU WANT **(called `toTable`)
3. Put such two files into `resources/sqlDir`
4. Finally, refer to the `demoFromFile` of `Demo.java` 
##### From URL
1. Finally, refer to the `demoFromUrl` of `Demo.java` 

#### Contact Me
* Email: 852778163@qq.com

#### License
* BSD
