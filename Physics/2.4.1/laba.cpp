#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define type float

int main () {
    int i = 0;
    int quantity = 0;
    type * x_data = NULL;
    type * y_data = NULL;
    float xy = 0;
    float x = 0;
    float y = 0;
    float xx = 0;
    float x2 = 0;
    float b = 0;
    float a = 0;
    float yy = 0;
    float y2 = 0;

    float sigma_b = 0;
    float sigma_a = 0;
    FILE * potok = fopen ("data.txt", "r+");

    fscanf (potok, "%d", &quantity);

    x_data = (type *) calloc (quantity, sizeof (type));
    y_data = (type *) calloc (quantity, sizeof (type));

    for (i = 0; i < quantity; i++)
    {
        fscanf (potok, "%f", &y_data[i]);
    }

    for (i = 0; i < quantity; i++)
    {
        fscanf (potok, "%f", &x_data[i]);
    }

    for (i = 0; i < quantity; i++)
    {
        printf ("Data y: %f\n", y_data[i]);
    }

    for (i = 0; i < quantity; i++)
    {
        printf ("Data x: %f\n", x_data[i]);
    }

    printf ("Formula for $<xy>:$\n\n$(");

    for (i = 0; i < quantity; i++)
    {
        xy += x_data[i] * y_data[i];

        printf ("%.3f \\cdot %f", x_data[i], y_data[i]);

        if (i + 1 < quantity) printf (" + ");
    }

    xy /= quantity;
    printf (") / %d$\n\n", quantity);

    printf ("Formula for $<x>:$\n\n$(");

    for (i = 0; i < quantity; i++)
    {
        x += x_data[i];

        printf ("%.3f", x_data[i]);

        if (i + 1 < quantity) printf (" + ");
    }

    x /= quantity;
    printf (") / %d$\n\n", quantity);

    printf ("Formula for $<y>:$\n\n$(");

    for (i = 0; i < quantity; i++)
    {
        y += y_data[i];

        printf ("%.3f", y_data[i]);

        if (i + 1 < quantity) printf (" + ");
    }

    y /= quantity;
    printf (") / %d$\n\n", quantity);

    printf ("Formula for $<x^2>$:\n\n$(");

    for (i = 0; i < quantity; i++)
    {
        xx += x_data[i] * x_data[i];

        printf ("%.3f^2", x_data[i]);

        if (i + 1 < quantity) printf (" + ");
    }

    xx /= quantity;
    printf (") / %d$\n\n", quantity);

    printf ("Formula for $<y^2>:$\n\n$(");

    for (i = 0; i < quantity; i++)
    {
        yy += y_data[i] * y_data[i];

        printf ("%.3f^2", y_data[i]);

        if (i + 1 < quantity) printf (" + ");
    }

    yy /= quantity;
    printf (") / %d$\n\n", quantity);

    x2 = x * x;
    y2 = y * y;

    b = (xy - x * y) / (xx - x2);

    printf ("\n\n$y = a + bx$\n\n");

    printf ("$b = \\frac{<xy> - <x><y>}{<x^2> - <x>^2} = \\frac{%.2f - %.2f \\cdot %.2f}{%.2f - %.2f} = %.2f$\n\n", xy, x, y, xx, x2, b);

    a = y - b * x;

    printf ("$a =<y> - b<x> = %.2f - %.2f \\cdot %.2f = %.2f$\n\n", y, b, x, a);

    sigma_b = (yy - y2) / (xx - x2) - b * b;
    sigma_b = (1 / sqrt (quantity)) * sqrt (sigma_b);

    printf ("$\\sigma_b = \\frac{1}{\\sqrt{n}} \\sqrt { \\frac{<y^2> - <y>^2}{<x^2> - <x>^2}  - b^2} = "
            "\\frac{1}{%.3f} \\sqrt {\\frac{%.6f - %.6f}{%.6f - %.6f} - %.3f} = %.6f$\n\n", sqrt (quantity), yy, y2, xx, x2, b, sigma_b);

    sigma_a = sigma_b * sqrt (xx - x2);

    printf ("$\\sigma_a = \\sigma_b \\sqrt{<x^2> - <x>^2} = %.6f \\sqrt{%.6f - %.6f} = %.6f$\n\n", sigma_b, xx, x2, sigma_a);

    fclose (potok);

    if (x_data != NULL) free (x_data);
    if (y_data != NULL) free (y_data);

    return 0;
}
