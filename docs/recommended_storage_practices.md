# Recommended storage practices

This is a guideline how to store the data so that we all can use the server equally productive.

This is not a final version, please feel free to change it if needed.

## Storage on external drives

All raw data must be backed up outside of the server.

External drives should only be connected while transferring the data. At least one USB port must remain free at all times for other users.
Drives left connected without active use should be disconnected. 

## Storage on `/scratch`

Data that is being actively worked on should be located on `/scratch` due to its higher I/O performance relative to external storage.
Data that is not needed anymore should be moved to backup or deleted as soon as possible, so that other users can use the memory.
Files inactive for 12 months stored on `/scratch` will be flagged. The owning user will be notified via email about further possibilities.
If no action is taken within 30 days, the data may be deleted.
