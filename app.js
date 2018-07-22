import express from 'express';
import bodyParser from 'body-parser';
import logger from 'morgan';
import path from 'path';
import swaggerUi from 'swagger-ui-express';
import cors from 'cors';
import YAML from 'yamljs';


const app = express();

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(logger('dev'));

const swaggerDocument = YAML.load(`${process.cwd()}/swagger.yaml`);
app.use(cors({ credentials: true, origin: true }));
app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerDocument));


const port = process.env.PORT || 3001;
// app.use('/api/v1/');

app.use('/', express.static(path.join(__dirname, 'UI')));


app.listen(port, () => console.log(`Application started on port ${port}, ${process.cwd()}, ${__dirname}`));
export default app;
