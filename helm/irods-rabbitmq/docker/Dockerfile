# SPDX-FileCopyrightText: 2024 Renaissance Computing Institute. All rights reserved.
#
# SPDX-License-Identifier: GPL-3.0-or-later
# SPDX-License-Identifier: LicenseRef-RENCI
# SPDX-License-Identifier: MIT

# adapted from:
# http://mpas.github.io/post/2015/06/11/20150611_docker-rabbitmq-default-users/

FROM rabbitmq:3.9-management

# Add script to create default users / vhosts
ADD init.sh /init.sh

# expose the two important queue ports
EXPOSE 15672
EXPOSE 5672

# Set correct executable permissions
RUN chmod +x /init.sh

# create a new non-root user
RUN useradd -M -u 1000 nru

# switch to the non-root user
USER nru

# Define default command
CMD ["/init.sh", "/"]
