#!/bin/bash

ps aux | grep [L]earningSnap | awk '{print $2}' | xargs kill

echo 0


