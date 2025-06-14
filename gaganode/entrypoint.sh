#!/bin/bash

# Install GaGaNode service
echo "Installing GaGaNode service..."
./apphub service install

# Start the service
echo "Starting GaGaNode service..."
./apphub service start

# Check status
echo "Checking status..."
./apphub status

# Wait for service to fully initialize
sleep 30

# Set token if provided
if [ ! -z "$GAGANODE_TOKEN" ]; then
    echo "Setting GaGaNode token..."
    ./apps/gaganode/gaganode config set --token="$GAGANODE_TOKEN"
    echo "Token configuration completed"
    
    # Restart to apply token
    echo "Restarting GaGaNode..."
    ./apphub restart
    
    # Wait for restart to complete
    sleep 10
    
    # Check logs
    echo "Checking gaganode logs..."
    ./apps/gaganode/gaganode log
fi

# Keep container running and show logs periodically
echo "GaGaNode is running. Monitoring logs..."
while true; do
    echo "================== apphub log =================="
    ./apphub log
    echo "================== gaganode log =================="
    ./apps/gaganode/gaganode log 2>/dev/null || echo "gaganode log not available"
    echo "==============================================="
    sleep 60
done
