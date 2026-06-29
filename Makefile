NAME		= inception

COMPOSE_FILE	= srcs/docker-compose.yml
COMPOSE		= sudo docker compose -f $(COMPOSE_FILE)

DATA_PATH	= /home/arocca/data
WORDPRESS_PATH	= $(DATA_PATH)/wordpress
MARIADB_PATH	= $(DATA_PATH)/mariadb

MKDIR		= mkdir -p
RM		= rm -rf

GREEN		= \033[1;32m
YELLOW		= \033[1;33m
RED		= \033[1;31m
RESET		= \033[0m

all: up

build:
	@$(COMPOSE) build

$(NAME):
	@sudo $(MKDIR) $(WORDPRESS_PATH) $(MARIADB_PATH)
	@echo "$(GREEN)Starting $(NAME) with logs...$(RESET)"
	@$(COMPOSE) up --build

up:
	@sudo $(MKDIR) $(WORDPRESS_PATH) $(MARIADB_PATH)
	@echo "$(GREEN)Starting $(NAME) in detached mode...$(RESET)"
	@$(COMPOSE) up --build -d

down:
	@echo "$(YELLOW)Stopping $(NAME) containers...$(RESET)"
	@$(COMPOSE) down

clean:
	@echo "$(YELLOW)Cleaning $(NAME)...$(RESET)"
	@$(COMPOSE) down -v --remove-orphans
	@sudo rm -rf $(WORDPRESS_PATH)
	@sudo rm -rf $(MARIADB_PATH)
	@sudo mkdir -p $(WORDPRESS_PATH) $(MARIADB_PATH)
	@echo "$(GREEN)Project data removed. Next launch will start from a clean state.$(RESET)"

fclean:
	@echo "$(RED)Full reset of $(NAME): containers, volumes, images, build cache, local data...$(RESET)"
	@$(COMPOSE) down -v --remove-orphans --rmi all
	@sudo docker builder prune -af
	@sudo $(RM) $(WORDPRESS_PATH)
	@sudo $(RM) $(MARIADB_PATH)
	@echo "$(GREEN)$(NAME) fully reset. Next build starts from zero.$(RESET)"

re: fclean up

logs:
	@$(COMPOSE) logs -f

ps:
	@$(COMPOSE) ps

restart: down up

reset-data: clean up

.PHONY: all up down clean fclean re logs ps restart reset-data