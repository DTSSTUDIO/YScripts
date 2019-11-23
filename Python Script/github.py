import os
from datetime import datetime
from pydriller import RepositoryMining
from urllib import parse

before = datetime(2019, 11, 15)
now = datetime.now()

TEMPLATE = "https://github.com/YEmreAk/IstanbulUniversity-CE/commit/{}?diff=split"


with open("../IstanbulUniversity-CE/CHANGELOG.md", "w+", encoding="utf-8") as file:
    file.write("# ✨ Değişiklikler")
    file.write("\n\n")
    file.write("## 📋 Tüm Değişiklikler")
    file.write("\n\n")

    for commit in RepositoryMining('../IstanbulUniversity-CE', reversed_order=True).traverse_commits():
        hash_value = commit.hash
        print(commit.hash, commit.parents)
        commit.project_path
        time = commit.author_date.strftime("%d/%m/%Y - %H:%M:%S")
        msg = commit.msg
        title = msg.split("\n")[0]

        file.write(f"- [{title} ~ {str(time)}]({TEMPLATE.format(hash_value)})\n")
