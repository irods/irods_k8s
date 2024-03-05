#!/bin/sh

# SPDX-FileCopyrightText: 2024 Renaissance Computing Institute. All rights reserved.
#
# SPDX-License-Identifier: GPL-3.0-or-later
# SPDX-License-Identifier: LicenseRef-RENCI
# SPDX-License-Identifier: MIT

(
sleep 60 ; \

# Create users
# rabbitmqctl add_user <username> <password>
rabbitmqctl add_user admin "$QUEUE_ADMIN_PW" ; \
rabbitmqctl add_user "$QUEUE_USER" "$QUEUE_PW" ; \

# Set user rights
# rabbitmqctl set_user_tags <username> <tag>
rabbitmqctl set_user_tags admin administrator ; \
rabbitmqctl set_user_tags "$QUEUE_USER" administrator ; \

for vhost in "$@"
do
# Create vhosts
# rabbitmqctl add_vhost <vhost name>
rabbitmqctl add_vhost "$vhost" ; \

# set the max message size
# rabbitmqctl set_policy -p $vhost --apply-to queues max-msg-size "^queue.name.pattern$" '{"max-length-bytes":512000000}'

# Set vhost permissions
# rabbitmqctl set_permissions -p <vhost name> <username> ".*" ".*" ".*"
rabbitmqctl set_permissions -p "$vhost" admin ".*" ".*" ".*" ; \
rabbitmqctl set_permissions -p "$vhost" "$QUEUE_USER" ".*" ".*" ".*" ; \
done
) &    
rabbitmq-server
