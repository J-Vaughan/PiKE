# PiKE is an ncurses communication tool for Raspberry Pi
# Copyright (C) 2020 Jimmy Vaughan
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.
#-----------------------------------------------------------------------------#
################################## Defaults ###################################
# Use > instead of tabs for recipes
ifeq ($(origin .RECIPEPREFIX), undefined)
  $(error This Make does not support .RECIPEPREFIX. Please use GNU Make 4.0 or later)
endif
.RECIPEPREFIX = >
# Written in/with bash
SHELL := bash
# Use bash strict mode
#   e    - immediately exits if any command returns nonzero
#   u    - cannot use variables before definition
#   o... - prevents errors in pipelines from being masked
.SHELLFLAGS := -eu -o pipefail -c
# Each recipe runs in one shell session
.ONESHELL:
# Deletes broken results of misbehaving recipes
.DELETE_ON_ERROR:
# Make warns of usage of nonexistent Make variables
MAKEFLAGS += --warn-undefined-variables
# Removes "magic"
MAKEFLAGS += --no-builtin-rules
#-----------------------------------------------------------------------------#
########################### Variables/Configuration ###########################
# C Compiler
CC = gcc
# Flags for C Compiler
CCFLAGS = -std=gnu17 -Wall -Wpedantic
# Source files
SOURCES = src/main.c
# Object files
OBJECTS = main.o 
#-----------------------------------------------------------------------------#
############################### Main Document #################################
# Default rule
build: pike
.PHONY: build

pike: $(OBJECTS)
> $(CC) -o $@ $^

main.o: src/main.c
> $(CC) $(CCFLAGS) -c $<
