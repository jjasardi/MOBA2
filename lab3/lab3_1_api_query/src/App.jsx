import { useState, useEffect } from 'react';
import Recipes from './Recipes';


function App() {
  const [recipes, setRecipes] = useState([])

  useEffect(() => {
    fetch(`https://api.edamam.com/api/recipes/v2?type=public&q=lasagne&app_id=99f38130&app_key=992c90773caa9ac819fd596ca86e87f5`)
      .then((response) => {
        if (!response.ok) {
          throw new Error(`Network response was not ok: ${response.status}`);
        }
        return response.json();
      })
      .then((data) => {
        setRecipes(data.hits)
      })
      .catch((error) => {
        console.error('Error fetching data:', error);
      });
  }, [])


  return (
    <>
      <Recipes recipes={recipes}></Recipes>
    </>
  )
}

export default App
