from datetime import datetime as dt
import xmltodict

fname = "CAM2ELOT.xml"
with open(fname, 'r') as reader:
    # Read & print the entire file
    xml_data = reader.read()

# Print milestones
data = xmltodict.parse(xml_data)
task_list = data['Project']['Tasks']['Task']
for tl in task_list:
    lev = int(tl["OutlineLevel"])
    # if lev == 2: print("\n")
    if tl["Milestone"] == "1": 
        fname = title = tl["Name"]
        if "Notes" in tl.keys(): title = tl["Notes"]
        date = dt.fromisoformat(tl["Finish"]).strftime("%Y-%m-%d")
        print(f"{title}; {date}; {fname}")

