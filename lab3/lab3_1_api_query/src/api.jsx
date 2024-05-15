export const fetchRecipes = async () => {
    try {
        const response = await fetch(`https://api.edamam.com/api/recipes/v2?q=lasagne&app_id=99f38130&app_key=992c90773caa9ac819fd596ca86e87f5`)
        const data = await response.json();
        return data.hits;
    } catch (error) {
        console.error('Error fetching data:', error);
        return [];
    }
}