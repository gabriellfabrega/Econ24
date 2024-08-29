import { Text, View, Image, StyleSheet, TouchableOpacity } from 'react-native';


export default function Pix({ route, navigation }) {

    const { obj, mqtt, valor, id } = route.params;

    function confirmar() {
        if (mqtt) {
            const msg = {
                id: id,
                valor: valor,
                forma: "PIX",
                situacao: "APROVADO"
            };

            const message = new Paho.MQTT.Message(JSON.stringify(msg));
            message.destinationName = '/payment-response';
            mqtt.send(message);
            navigation.goBack();
        }
    }

    return (
        <View style={styles.container}>
            <Image
                source={require('../../assets/pix.png')}
                style={styles.image}
            />


            <Image
                source={require('../../assets/qrcode.png')}
                style={styles.imageQr}
            />

            <Text> {obj.idTransacaoOrigem} </Text>
            <Text style={styles.textoValor}> {valor.toFixed(2)} </Text>

            <TouchableOpacity style={styles.botaoConfirmar} onPress={() => confirmar()}>
                <Text style={styles.textoConfirmar}> Confirmar </Text>
            </TouchableOpacity>
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
    imageQr: {
        width: 200,
        height: 200,
        marginTop: 5,
    },
    textoValor: {
        fontSize: 50,
        color: '#00BDAE'
    },
    botaoConfirmar: {
        backgroundColor: '#00BDAE',
        width: '70%',
        height: 50,
        marginTop: 30,
        alignItems: 'center',
        justifyContent: 'center',
        borderRadius: 30

    },
    textoConfirmar: {
        fontSize: 20,
        color: 'black'
    }
});