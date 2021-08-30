module.exports.handler = async (event) => {
  console.log('Event: ', event);
  let responseMessage = 'Messsage';

  if (event.queryStringParameters && event.queryStringParameters['Name']) {
    responseMessage = 'Hi, ' + event.queryStringParameters['Name'] + '!';
  }

  return {
    statusCode: 200,
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({
      body: JSON.parse(event.body),
      headers: event.headers,
      method: event.httpMethod
      
    }),
  }
}