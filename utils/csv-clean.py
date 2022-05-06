import sys

csv = ["Host,Port,Status,Protocol,Service\n"]
with open(sys.argv[1]) as file:
    for line in file:
        if "closed" in line: continue

        lines = line.split(",")[:5]
        str=",".join(lines)
        if not str.endswith("\n"): str+="\n"
        csv.append(str)

with open(sys.argv[1], "w") as file:
    file.writelines(csv)