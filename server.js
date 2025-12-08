const express = require('express');
const cors = require('cors');
const items = require('./data/items');

const app = express();
const PORT = 3000;

app.use(cors());
app.use(express.json());

app.use(express.static('public'));


let currentIndex = 0;

const wrapIndex = (index) => {
  const total = items.length;
  return ((index % total) + total) % total;
};

// GET /item : returns the current item
app.get('/item', (req, res) => {
  res.json({
    currentIndex: currentIndex,
    item: items[currentIndex],
    total: items.length
  });
});

// GET /item/next : moves to next item
app.get('/item/next', (req, res) => {
  currentIndex = wrapIndex(currentIndex + 1);
  res.json({
    currentIndex: currentIndex,
    item: items[currentIndex],
    total: items.length
  });
});

// GET /item/prev : moves to previous item
app.get('/item/prev', (req, res) => {
  currentIndex = wrapIndex(currentIndex - 1);
  res.json({
    currentIndex: currentIndex,
    item: items[currentIndex],
    total: items.length
  });
});

// GET /item/:id : returns item by index (optional)
app.get('/item/:id', (req, res) => {
  const id = parseInt(req.params.id);
  
  if (isNaN(id) || id < 0 || id >= items.length) {
    return res.status(400).json({
      error: 'Invalid index',
      message: `Index must be between 0 and ${items.length - 1}`
    });
  }
  
  currentIndex = id;
  res.json({
    currentIndex: currentIndex,
    item: items[currentIndex],
    total: items.length
  });
});

// GET /items : returns all items
app.get('/items', (req, res) => {
  res.json({
    items: items,
    total: items.length
  });
});


// GET / : go on the main page
app.get('/', (req, res) => {
  res.sendFile(__dirname + '/public/index.html');
});

app.listen(PORT, () => {
  console.log(` Backend server running on http://localhost:${PORT}`);
  console.log(` Total items loaded: ${items.length}`);
});
