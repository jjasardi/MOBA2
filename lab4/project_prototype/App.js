import { StatusBar } from 'expo-status-bar';
import { StyleSheet, Text, View } from 'react-native';
import Results from './Results'
import exampleData from './data/example_response.json'

export default function App() {
  return (
    <View style={styles.container}>
      <Text>Search results</Text>
      <Results data={exampleData.hits}></Results>
      <StatusBar style="auto" />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
    alignItems: 'center',
    justifyContent: 'center',
    marginTop: 40
  },
});
