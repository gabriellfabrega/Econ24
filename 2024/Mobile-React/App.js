import React from 'react';
import { NavigationContainer } from '@react-navigation/native';
import { createNativeStackNavigator } from '@react-navigation/native-stack';
import Home from './pages/Home';
import Pix from './pages/Pix';

const Stack = createNativeStackNavigator();

export default function App() {
  return (

    <NavigationContainer>
      <Stack.Navigator initialRouteName="Home">
        <Stack.Screen name="Home" component={Home}   options={{ headerShown: false }}/>
        <Stack.Screen name="Pix" component={Pix}   options={{ headerShown: false }}/>

      </Stack.Navigator>
    </NavigationContainer>

  );
}