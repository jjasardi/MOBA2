import React from 'react';
import { View, Image, ScrollView, Text, StyleSheet } from 'react-native';

const Results = ({ data }) => (
    <ScrollView>
        {data.map((singleData => (
            <View key={singleData.recipe.uri}>
                <Text>{singleData.recipe.label}</Text>
                <Image
                    source={{ uri: singleData.recipe.images.THUMBNAIL.url }}
                    style={styles.image}>
                </Image>
            </View>
        )))}
    </ScrollView>
)

const styles = StyleSheet.create({
    image: {
        width: 100,
        height: 100,
    },
})

export default Results