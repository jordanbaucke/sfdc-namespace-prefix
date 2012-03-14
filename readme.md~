Quickly Add Namespace Prefixes to SFDC Meta-data Source-code

**Namespace Prefixes are required for ALL managed packages (THAT ARE UPLOADED TO THE [APPEXCHANGE][1]!).**

**Namespace prefixes are automatically inserted in managed packages that are not distributed
to the AppExchange, except in Javascript calls to @RemoteAction methods, and in actionFunction
All webservice package references must reference a namespace prefix for 
deployed code to correctly reference installed packages.

References to custom objects must reference a namespace prefix in API calls:

***NSP1\_\_MyCustomObject__c***

Managed packages on the SFDC Platform cannot rename/remove member classes, 
custom objects, visualforce pages, etc. Therefore, a namingConventions.txt
file will also be run on each individaul file to help users develop a 
generic copy of the code in non-managed package developer orgs, to have
classnames and org methods updated.

_Example_:

<code>OriginalNameString.cls --> PackagedNameString.cls</code>

-and-

<code>public OriginalNameString(){ //... } --> public PackageNameString(){ //... }</code>

---

## Updates 
- **11/30/2011** - Created Github repo, started construction of methods.

- **12/8/2011** - Added a 2nd script that was more targeted at JUST replacing namespaces (the first one became too focused on)
doing one-off replacements to keep legacy class definitions from changing in packaged code.

- **12/14/2011** - Modified the script to be more dynamic, adding two naming-consideration .txt files (with simple examples):

naming_considerations.txt: text name changes that are made in code (for namespacing, labels, find and replace etc.)
file_naming_considerstions.txt: renames files as needed

Format of both *naming_considerations.txt: ORIGINAL-LABEL:NEW-LABEL

**the example operation may not run if you have profiles associated with the tabs/apps that cannot be modified

### NEW USAGE (ARGS):

<code>$ruby naming_considerations SRC_DIR_TARGET_PATH PATH_TO_NAMING_CONSIDERATIONS.TXT PATH_TO_FILE_NAMING_CONSIDERATIONS.TXT</code>

Resources:
http://wiki.developerforce.com/page/Bestpractices:Continuous_Integration_Techniques

Background:
http://bracketlabs.com/blog/2011/7/25/salesforces-apex-namespace-requirement-creates-barrier-to-co.html

About:</br>
@[jordanbaucke][2]</br>
[www.bracketlabs.com: Agile Project Management for Salesforce.com][3]

[1]:http://www.appexchange.com/
[2]:http://twitter.com/jordanbaucke/
[3]:http://www.bracketlabs.com/taskray/
