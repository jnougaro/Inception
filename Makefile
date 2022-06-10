# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jnougaro <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/05/10 14:21:02 by jnougaro          #+#    #+#              #
#    Updated: 2022/05/10 14:21:04 by jnougaro         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = inception

all:
		@ sudo mkdir -p /home/jnougaro/data/wp_data/
		@ sudo mkdir -p /home/jnougaro/data/db_data/
		
		@ cd srcs/ && sudo docker-compose up -d --build

clean:
		@ cd srcs/ && sudo docker-compose down
		@ -docker rmi -f nginx wordpress mariadb
		@ -docker rm -f nginx wordpress mariadb

fclean: clean
		@ sudo rm -rf /home/jnougaro/data/wp_data
		@ sudo rm -rf /home/jnougaro/data/db_data


re: fclean all

.PHONY: clean fclean re all
