# powerbi-governance-suite
A collection of tools, scripts, and best practices for Power BI governance, automation, and metadata management.


A comprehensive collection of Power Query functions, PowerShell scripts, and best practices designed to support Power BI governance, automation, and metadata management across an enterprise environment.

This suite provides practical tools for:

Retrieving and understanding tenant-wide metadata

Inspecting gateway datasources and connections

Auditing activity logs and API events

Automating REST API calls

Supporting governance dashboards built in Power BI

Cross-referencing Dataset IDs, Gateway IDs, and Connection Details

Exporting metadata to Excel or other tools for offline analysis

Most Power BI metadata — including gateways, datasources, datasets, and workspace details — can be directly retrieved using Power Query. These M-scripts are ideal for powering automated, refreshable dashboards and governance reports.

However, for more complex cross-referencing and admin workflows, such as matching:

Dataset IDs → Gateway Connection IDs

Connection Names → Datasource Names → Dataset Names

Gateway configuration → Dataset dependencies

…it is often easier and more flexible to use PowerShell. PowerShell allows looping through APIs, exporting results to Excel/CSV, and preparing data for upload into Power BI, making it a perfect complement to the M-based governance tools.

Together, these two approaches form a complete metadata and governance toolkit that supports both interactive analysis in Power BI and scripted automation for administrators.
