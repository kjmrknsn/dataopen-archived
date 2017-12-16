# Data Open

## Overview
Data Open is a web-based collaborative data analysis platform. Users can extract, analyze and visualize data by writing Spark application code and submitting it to a Hadoop cluster. Analysis results can be shared with others as a form of a notebook.

### Secure
Data Open adopts LDAP authentication and authorization. A Data Open user is set to a Spark application user that works well with a Hadoop cluster whose data access is controlled via Apache Ranger. In addition, editors and readers of an analysis result can be restricted to some users and groups.

### Scalable
Data Open can run on multiple servers so that it can deal with increase of the number of users.
