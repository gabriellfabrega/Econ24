import React, { useEffect, useState } from 'react';
import { View, Text, Button, StyleSheet } from 'react-native';
import init from 'react_native_mqtt';
import { AsyncStorage } from '@react-native-async-storage/async-storage';


export default function Home({ navigation }) {

    init({
        size: 10000,
        storageBackend: AsyncStorage,
        defaultExpires: 1000 * 3600 * 24,
        enableCache: true,
        reconnect: true,
        sync: {}
    });

    const [client, setClient] = useState(null);
    const [isConnected, setIsConnected] = useState(false);

    useEffect(() => {
        const mqttClient = new Paho.MQTT.Client('ec2-54-175-73-62.compute-1.amazonaws.com', 8083, '/mqtt', 'clientId');

        mqttClient.onConnectionLost = (responseObject) => {
            if (responseObject.errorCode !== 0) {
                console.log('onConnectionLost:' + responseObject.errorMessage);
            }
            setIsConnected(false);
        };

        mqttClient.onMessageArrived = (message) => {
            const obj = JSON.parse(message.payloadString);
            navigation.navigate('Pix', { obj, mqtt: mqttClient, id: obj.id, valor: obj.valor });
       

        };

        mqttClient.connect({
            onSuccess: () => {
                setIsConnected(true);
                mqttClient.subscribe('/mqtt/payment-request')
                            },
            useSSL: false,
            cleanSession: true,
            onFailure: (e) => {
                console.log('Failed to connect:', e);
            }
        });

        setClient(mqttClient);

        return () => {
            if (client) {
                client.disconnect();
            }
        };
    }, []);


    return (
        <View style={styles.container}>
            {isConnected ? <Text>Connected to EMQX</Text> : <Text>Disconnected</Text>}
            <View style={styles.row}>
                <Text style={styles.texto1}>Conference</Text>
                <Text style={styles.texto2}>Pay</Text>
            </View>
        </View>
    );
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        alignItems: 'center',
        backgroundColor: 'white'
    },
    image: {
        width: 100,
        height: 100,
        marginTop: 90,
    },
    texto1: {
        fontSize: 50,
        color: 'black'
    },
    texto2: {
        fontSize: 50,
        color: '#00BDAE'
    },
    row: {
        flexDirection: 'row',
        width: '100%', 
        justifyContent: 'center',
        marginTop: 250
    },
});
